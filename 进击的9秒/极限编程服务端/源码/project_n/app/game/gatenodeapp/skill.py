#coding:utf8
'''
Created on 2013年10月28日

@author: lan (www.9miao.com)
'''

from app.game.gatenodeservice import remoteserviceHandle
import json
from app.game.appinterface import skill

@remoteserviceHandle
def getSkillTreeInfo_801(dynamicId,request_proto):
    """获取技能信息
    """
    argument = json.loads(request_proto)
    characterId = argument.get('characterId')
    response = skill.getSkillTreeInfo(dynamicId, characterId)
    return json.dumps(response)


@remoteserviceHandle
def learnSkill_802(dynamicId,request_proto):
    """学习技能
    """
    argument = json.loads(request_proto)
    characterId = argument.get('characterId')
    skill_id = argument.get('skill_id')
    response = skill.learnSkill(dynamicId, characterId, skill_id)
    return json.dumps(response)

@remoteserviceHandle
def getlearnedSkilsl_803(dynamicId,request_proto):
    """获取已经学习的技能
    """
    argument = json.loads(request_proto)
    characterId = argument.get('characterId')
    response = skill.getLearnedSkills(dynamicId, characterId)
    return json.dumps(response)

@remoteserviceHandle
def getPetSkillSetting_804(dynamicId,request_proto):
    """获取伙伴技能设置
    """
    argument = json.loads(request_proto)
    characterId = argument.get('characterId')
    pet_id = argument.get('pet_id')
    response = skill.getPetSkillSetting(dynamicId, characterId, pet_id)
    return json.dumps(response)

@remoteserviceHandle
def updateSkillSetting_805(dynamicId,request_proto):
    """装备技能
    """
    argument = json.loads(request_proto)
    characterId = argument.get('characterId')
    skill_id = argument.get('skill_id')
    pet_id = argument.get('pet_id')
    space = argument.get('space')
    response = skill.updateSkillSetting(dynamicId, characterId, pet_id, skill_id, space)
    return json.dumps(response)

