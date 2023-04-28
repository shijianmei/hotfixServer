import { PaginateValidator, LinValidator } from "lin-mizar";
import { Rule } from 'lin-mizar/lin'

class HotFixValidator extends LinValidator {
  constructor () {
    super();
    this.group_id = [
      new Rule('isOptional'),
      new Rule('isInt', '分组id必须为正整数', { min: 1 })
    ];
  }
}

class AddHotFixValidator extends LinValidator {
    constructor () {
      super();
      this.platform = [
        new Rule('isNotEmpty', '必须指定新系统类型'),   
        new Rule('isInt', '平台类型必须是数字')     
      ]

      // this.type = [
      //   new Rule('isNotEmpty', '资源类型不能为空'),
      // ]
      this.status = [
        new Rule('isOptional'),
        // new Rule('isInt', '内容有效状态标识不正确')
      ]
      this.version = [
        new Rule('isNotEmpty', 'app版本不能为空'),        
      ]     
    }
  }

  class EditHotFixValidator extends LinValidator {
    constructor () {
      super();
      this.status = [
        new Rule('isOptional'),
        new Rule('isInt', '内容有效状态标识不正确')
      ]          
    }
  }

export { HotFixValidator, AddHotFixValidator, EditHotFixValidator }
