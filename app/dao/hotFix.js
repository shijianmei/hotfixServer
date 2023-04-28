import { NotFound } from "lin-mizar";
import { HotFixModel } from "../model/hotFix";
import { Op } from 'sequelize';

// 在Dao层中调用模型层
class HotFix {
  static async createHotFix(v) {
    const res = await HotFixModel.create(v)
    return res
  }

  static async getHotFixListForValid(pVersion, pPlatform) {
    var platform = 0
    if (pPlatform) {
      platform = pPlatform;
    }
    const res = await HotFixModel.findAll({      
      where: {
        version: pVersion,
        platform: platform,
        status: 1,
      }
    });  
    return res;
  }

  static async getNewHotFixListForValid(pVersion, pPlatform, pPatch) {
    var platform = 0
    var patch = 0
    if (pPlatform) {
      platform = pPlatform;
    }
    if (pPatch) {
      patch = pPatch;
    }
    const res = await HotFixModel.findAll({      
      where: {
        version: pVersion,
        platform: platform,        
        status: 1,
        id: {
          [Op.gt]: patch
        }
      }
    });  
    return res;
  }


  static async getHotFixList(page, count1) {
    const condition = { 
      order: [
        ['id', 'DESC']
      ],
      offset: (page - 1)* count1,
      limit: parseInt(count1)
    };    
    const { rows, count } = await HotFixModel.findAndCountAll(condition);    
    return {
      fixList: rows,
      total: count
    };
  }


  static async editHotFix(id, status) {
    const flow = await HotFixModel.findByPk(id)
    if (!flow) {
      throw new NotFound();
    }

    await flow.update({ id, status })
  }

}

export { HotFix as HotFixDao }
