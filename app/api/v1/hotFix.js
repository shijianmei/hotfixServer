import { LinRouter } from "lin-mizar";
import { HotFixDao } from "../../dao/hotFix";
import { groupRequired } from "../../middleware/jwt";
import { logger } from "../../middleware/logger";
import { HotFixService } from "../../service/hotFix";
import { HotFixValidator, AddHotFixValidator, EditHotFixValidator } from '../../validator/hotFix'
const fs = require("fs")

const hotFixApi = new LinRouter({
    prefix: "/v1/hotFix",
});

const validHotFixApi = new LinRouter({
  prefix: "/v1/validHotFix",
});

const exitHotFixApi = new LinRouter({
  prefix: "/v1/exitHotFix",
});

/**
 * 新增热修复
 */
hotFixApi.linPost(
    "addHotFix", // 函数唯一标识
    "/",
    {
      permission: "新增热修复包", // 权限名称
      module: "热修复管理", // 权限所属模块
      mount: true,
    },
    groupRequired, // 权限级别
    logger("{user.username}新增了最新patch包"),
    async (ctx) => {           
      const v = await new AddHotFixValidator().validate(ctx);
      await HotFixService.addHotFix(v.get("body"));      
      // 4.返回成功
      ctx.success({
        msg: "热修复包新增成功",
      });
    }
  );
//获取热修复列表
  hotFixApi.linGet(
    'hotFix',
    '/',    
    {
      permission: "查询热修复包", // 权限名称
      module: "热修复管理", // 权限所属模块
      mount: true,
    },    
    groupRequired, // 权限级别
    async ctx => {
      const v = await new HotFixValidator().validate(ctx);
      const { fixList, total }= await HotFixDao.getHotFixList(
        v.get('query.page'),
        v.get('query.count')
      );
      ctx.json({
        items: fixList,
        total,
        count: v.get('query.count'),
        page: v.get('query.page')
      });
    }
  );

  hotFixApi.linPut(
    'editHotFix',
    '/:id',
    {
      permission: "更新热修复包状态", // 权限
      module: "热修复管理",
      mount: true
    },
    groupRequired, // 权限级别
    
    async ctx => {
      // 校验数据
      const v = await new EditHotFixValidator().validate(ctx)      
      const id = v.get('path.id')      
      const status = v.get('body.status')
      logger("{user.username}编辑了热修复包状态：{status}")
      await HotFixDao.editHotFix(id, status)
      ctx.success({
        msg: '状态已经更新'
      })
    })

  //获取有效的热修复列表 
  validHotFixApi.linGet(
    'validHotFix',
    '/',    
    {
      permission: "查询有效热修复包", // 权限名称
      module: "热修复管理", // 权限所属模块
      mount: true,
    },    
    async ctx => {

      const v = await new HotFixValidator().validate(ctx);
      const fixList = await HotFixDao.getHotFixListForValid(
        v.get('query.version'), 
        v.get('query.platform')       
      );
      const fixDict = fixList[0];

      var packageContent='';
      for (let i = 0; i < fixList.length; i++) {
        const path = fixList[i].path;
        var checkDir = fs.existsSync(path);

        if(! checkDir) {
          continue;
        }

        var data = fs.readFileSync(path, 'binary')      
        packageContent = data;
      }      
      ctx.res.writeHead(200)
      ctx.res.write(packageContent, 'binary')
      ctx.res.end()
    }
  );

  // 查询是否存在热修复
  exitHotFixApi.linGet(
    'exitHotFix',
    '/',
    {
      permission: "查询会否存在有效热修复包", // 权限名称
      module: "热修复管理", // 权限所属模块
      mount: true,
    }, 
    async ctx => {

      const v = await new HotFixValidator().validate(ctx);
      const fixList = await HotFixDao.getNewHotFixListForValid(
        v.get('query.version'), 
        v.get('query.platform'),
        v.get('query.patch'),       
      );
      var exitNew = false;
      const fixDict = fixList[0];
      var patchId = '';
      if (fixList.length > 0) {
        exitNew = true;
        patchId = fixDict.id;
      }
      ctx.json({
        exitNew: exitNew,  
        id: patchId            
      });
    }
  )
  module.exports = { hotFixApi, validHotFixApi, exitHotFixApi };
  