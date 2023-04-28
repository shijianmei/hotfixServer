import { HotFixDao } from "../dao/hotFix";
import { HotFixModel } from "../model/hotFix";


class HotFix {
    static async getFixList (page, count1) {
      const fixList = await HotFixDao.getHotFixList(page,count1);
      // 判断数组长度是否为0，为零直接返回
      if (fixList.length === 0) {
        return fixList
      }
      const newFixList = []
      for (let i = 0; i < fixList.length; i++) {
        let detail = await HotFixModel.findByPk(fixList[i].id);                
        newFixList.push(fixList[i])
      }
      return newFixList
    }

    static async addHotFix (v) {
        await HotFixDao.createHotFix(v);        
      }
  }

  export { HotFix as HotFixService }