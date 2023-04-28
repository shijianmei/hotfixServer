    ## 简介
    热修复包管理平台后端代码,支持热修复包的上传,发布,暂停,结束及热修复包请求接口

    ## 支持接口
    其中 上传接口, 发布接口, 暂停接口, 结束接口 ![管理平台前端](https://github.com/shijianmei/hotfixMS)调

    ### 供客户端调接口
    - 获取热修复包流接口
    http://localhost:5000/v1/validHotFix
    
    请求参数:
    | 参数名 | 位置	   |  类型	  | 必填	|  说明 |
    | version | query | string | 否 | 3.16.0 |
    
    - 获取是否存在最新热修复包接口
    https://hotfix-ios-api-pre.ai-ways.com/v1/exitHotFix
    
    请求参数:
    | 参数名 | 位置	   |  类型	  | 必填	|  说明 |
    | version | query | string | 否 | 示例值： 3.16.0 |
    | patch | query| string | 否 | 示例值：22 |

    ## 依赖库版本
    mysql:5.6+
    node.js 8.14.0+

    ## 安装 & 运行

    - 安装依赖包：`cd hotfixServer && yarn`

    - 导入数据表       
        然后找到根目录下的/schema.sql文件，并在 MySQL 中执行该脚本文件。

    - 数据库配置：
      打开工程的app/config/secure.js
        `
            module.exports = {
                db: {
                    database: "lin-cms",
                    host: "localhost",
                    port: 3306,
                    username: "root",
                    password: "12345678",
                    logging: false
                }
            };
        `
    - 域名配置：
        打开工程的app/config/setting.js,配置domain及文件上传域名
        
    - 运行： 
      node index.js
