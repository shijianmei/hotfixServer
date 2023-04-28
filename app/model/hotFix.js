import { Sequelize, Model } from "sequelize";
import sequelize from "../lib/db";
import { config } from 'lin-mizar';

class HotFix extends Model {

}

HotFix.init (
    {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      }, 
      package: {
        type: Sequelize.STRING(64),
        get () {        
          const file = this.getDataValue('package')
          return file
        }
      },     
      // 资源类型
      type: {
        type: Sequelize.STRING(32),
        allowNull: true,
      },
      // 0：iOS ,1: Android
      platform: {
        type: Sequelize.INTEGER,
        allowNull: true,
      },
      // 1:发布中, 2:暂停 ,0:结束
      status: {
        type: Sequelize.INTEGER,
        allowNull: true,
      },
      desc: {
        type: Sequelize.STRING(300),
        allowNull: true,
      },      
      resourceName: {
        type: Sequelize.STRING(64),
        allowNull: true,
      },
      version: {
        type: Sequelize.STRING(64),
        allowNull: true,
      },
      //资源路径
      path: {
        type: Sequelize.STRING(64),
        allowNull: true,
        get () {        
          const path = this.getDataValue('path')
          return './assets/' + path
        }
      },
    },
    {
      tableName: 'hotFix',
      modelName: 'hotFix',
      paranoid: true,
      underscored: true,
      timestamps: true,
      createdAt: 'created_at',
      updatedAt: 'updated_at',
      deletedAt: 'deleted_at',
      sequelize
    }
  )
   
  export { HotFix as HotFixModel }
  