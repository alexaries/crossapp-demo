#coding:utf8
'''
Created on 2013-10-25
角色的所学的技能信息
@author: lan (www.9miao.com)
'''
from app.game.component.Component import Component
from app.share.mem.memmode import tbcharacter_skill
from app.share.dbopear import dbSkill

class CharacterSkillComponent(Component):
    '''角色的所学的技能信息'''
    
    def __init__(self,owner):
        '''init Object'''
        Component.__init__(self, owner)
        #角色的宠物列表
        self._skills = []
        self.initCharacterSkillInfo()
        
    def initCharacterSkillInfo(self):
        '''初始化角色所学技能信息'''
        pid = self._owner.cid
        skilllist = tbcharacter_skill.getAllPkByFk(pid)
        petobjlist = tbcharacter_skill.getObjList(skilllist)
        for petmmode in petobjlist:
            skillinfo = petmmode.get('data')
            self._skills.append(skillinfo['skillId'])
            
    def getSkillTreeInfo(self):
        """获取技能信息
        """
        all_skill_list = dbSkill.ALL_SKILL_TEMPLATE.keys()
        learned_skill_list = self.getSkills()
        shop_skill_list = list(set(all_skill_list)-set(learned_skill_list))
        return {"result":True,"data":shop_skill_list}
        
        
    def getSkills(self):
        '''获取角色的宠物列表'''
        return self._skills
        
    def learnSkill(self,skill_id):
        """学习技能
        """
        if skill_id in self._skills:
            return {"result":False,"message":u"已经学会该技能"}
        if self._owner.coin<100:
            return {"result":False,"message":u"金币不足"}
        _pid = self._owner.cid
        _new_skill = tbcharacter_skill.new({"character_id":_pid,"skillId":skill_id})
        self._skills.append(skill_id)
        return {"result":True,"message":u"学习成功"}
        
    def isEquiped(self, skill_id):
        """判断技能是否已经装备
        """
        if not skill_id:
            return False
        _equiped_skill = set()
        for _pet in self._owner.pet._pets.values():
            _equiped_skill.add(_pet.skill_1)
            _equiped_skill.add(_pet.skill_2)
            _equiped_skill.add(_pet.skill_3)
        if skill_id in _equiped_skill:
            return True
        return False
        
    def equipSkill(self, pet_id, skill_id, space):
        """技能装备
        """
        if self.isEquiped(skill_id):
            return {"result":False, "message":u"技能已被装备"}
        if space not in [1,2,3]:
            return {"result":False, "message":u"位置参数错误"}
        _pet = self._owner.pet.getPet(pet_id)
        if not _pet:
            return {"result":False, "message":u"伙伴信息不存在"}
        _pet.updateSkill(space, skill_id)
        return {"result":True, "message":u"技能装备成功"}
        
    def getPetSkillSetting(self, pet_id):
        """获取伙伴技能设置
        """
        _pet = self._owner.pet.getPet(pet_id)
        if not _pet:
            return {"result":False, "message":u"伙伴信息不存在"}
        info = {"skill_1":_pet.skill_1, "skill_2":_pet.skill_2}
        return {"result":True, "data":info}
        
        
        
        