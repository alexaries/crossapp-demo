#coding:utf8
'''
Created on 2013年10月28日

@author: lan (www.9miao.com)
'''
from app.game.core.PlayersManager import PlayersManager

def getSkillTreeInfo(dynamicId, characterId):
    """获取所有技能信息
    """
    player = PlayersManager().getPlayerByID(characterId)
    if not player or not player.CheckClient(dynamicId):
        return {'result':False,'message':u""}
    return player.skill.getSkillTreeInfo()

def getLearnedSkills(dynamicId, characterId):
    """获取所有技能信息
    """
    player = PlayersManager().getPlayerByID(characterId)
    if not player or not player.CheckClient(dynamicId):
        return {'result':False,'message':u""}
    learned_skills = player.skill.getSkills()
    return {"result":True,"data":learned_skills}
    

def learnSkill(dynamicId, characterId, skill_id):
    '''学习技能
    '''
    player = PlayersManager().getPlayerByID(characterId)
    if not player or not player.CheckClient(dynamicId):
        return {'result':False,'message':u""}
    return player.skill.learnSkill(skill_id)

def updateSkillSetting(dynamicId, characterId, pet_id, skill_id, space):
    '''更新技能设置
    '''
    player = PlayersManager().getPlayerByID(characterId)
    if not player or not player.CheckClient(dynamicId):
        return {'result':False,'message':u""}
    return player.skill.equipSkill( pet_id, skill_id, space)


def getPetSkillSetting(dynamicId, characterId, pet_id):
    '''获取伙伴技能设置
    '''
    player = PlayersManager().getPlayerByID(characterId)
    if not player or not player.CheckClient(dynamicId):
        return {'result':False,'message':u""}
    return player.skill.getPetSkillSetting(pet_id)

