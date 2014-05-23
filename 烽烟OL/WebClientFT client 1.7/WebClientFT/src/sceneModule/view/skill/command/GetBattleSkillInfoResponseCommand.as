package sceneModule.view.skill.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.skill.skill801.GetSkillInfoResponse;
	import proto.skill.skill801.SkillInfoList;
	
	import sceneModule.model.vo.skillVo.SkillBasicInfoVo;
	import sceneModule.view.skill.event.GetBattleSkillInfoResponseEvent;

	public class GetBattleSkillInfoResponseCommand extends Command
	{
		[Inject]
		public var evt:GetBattleSkillInfoResponseEvent;
		public function GetBattleSkillInfoResponseCommand()
		{
			super();
		}
		override public function execute():void{
			var byteArray:ByteArray = evt.obj as ByteArray;
			var responseData:GetSkillInfoResponse = new GetSkillInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result && responseData.data){
				var l:int = responseData.data.skillInfoList.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var skillInfo:SkillInfoList = responseData.data.skillInfoList[i];
					var skillBaseInfo:SkillBasicInfoVo = new SkillBasicInfoVo();
					skillBaseInfo.icon = skillInfo.icon;
					skillBaseInfo.levelUpEffect = skillInfo.levelUpEffect;
					skillBaseInfo.levelUpMoney = skillInfo.levelUpMoney;
					skillBaseInfo.levelUpProps = skillInfo.levelUpProps;
					skillBaseInfo.levelUpRoleLevel = skillInfo.levelUpRoleLevel;
					skillBaseInfo.releasePreEnergy = skillInfo.releasePreEnergy;
					skillBaseInfo.remainRoleLevel = skillInfo.remainRoleLevel;
					skillBaseInfo.skillDes = skillInfo.skillDes;
					skillBaseInfo.skillId = skillInfo.skillId;
					skillBaseInfo.skillLevel = skillInfo.skillLevel;
					skillBaseInfo.skillName = skillInfo.skillName;
					skillBaseInfo.skillStatus = skillInfo.skillStatus;
					skillBaseInfo.type = skillInfo.type;
					skillBaseInfo.skillType = skillInfo.skillType;
					if(skillInfo.skillType == 3){
						arr.addItem(skillBaseInfo);
					}else{
						trace("战斗技能类型出错....");
					}
				}
				SystemDataModel.mainSkillInfo.battleSkillList.source = arr.toArray();
				
			}
		}
	}
}