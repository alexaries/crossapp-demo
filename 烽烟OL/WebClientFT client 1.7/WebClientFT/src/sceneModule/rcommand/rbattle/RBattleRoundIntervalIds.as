/**
 * 每回合战斗中所有timeout的IntervalId，保证每个setTimeOut用不同的ID，附上冲突，但是要清除。 
 */
private const MOVE_INTERVAL_ID_STR:String = "moveIntervalId";
private var moveIntervalId1:int;//移除时需要的ID
private var moveIntervalId2:int;//移除时需要的ID
private var moveIntervalId3:int;//移除时需要的ID
private var moveIntervalId4:int;//移除时需要的ID
private var moveIntervalId5:int;//移除时需要的ID

private var throwMoveIntervalId:int;//投身特效移动需要的ID

private const STAND_INTERVAL_ID_STR:String = "standIntervalId";
private var standIntervalId1:int;//近程攻击中，角色跑过去以后的站立延时ID
private var standIntervalId2:int;//近程攻击中，角色跑过去以后的站立延时ID
private var standIntervalId3:int;//近程攻击中，角色跑过去以后的站立延时ID
private var standIntervalId4:int;//近程攻击中，角色跑过去以后的站立延时ID
private var standIntervalId5:int;//近程攻击中，角色跑过去以后的站立延时ID
private var standIntervalId6:int;//近程攻击中，角色跑过去以后的站立延时ID
private var standIntervalId7:int;//近程攻击中，角色跑过去以后的站立延时ID
private var standIntervalId8:int;//近程攻击中，角色跑过去以后的站立延时ID
private var standIntervalId9:int;//近程攻击中，角色跑过去以后的站立延时ID

private var throwEffectIntervalId1:int;//投射特效播放需要的ID
private var throwEffectIntervalId2:int;//投射特效播放需要的ID

private const EFFECT_INTERVAL_ID_STR:String = "effectIntervalId";
private var effectIntervalId1:int;//特效播放需要的ID
private var effectIntervalId2:int;//特效播放需要的ID
private var effectIntervalId3:int;//特效播放需要的ID
private var effectIntervalId4:int;//特效播放需要的ID
private var effectIntervalId5:int;//特效播放需要的ID
private var effectIntervalId6:int;//特效播放需要的ID
private var effectIntervalId7:int;//特效播放需要的ID
private var effectIntervalId8:int;//特效播放需要的ID
private var effectIntervalId9:int;//特效播放需要的ID
private var effectIntervalId10:int;//特效播放需要的ID
private var effectIntervalId11:int;//特效播放需要的ID
private var effectIntervalId12:int;//特效播放需要的ID
private var effectIntervalId13:int;//特效播放需要的ID
private var effectIntervalId14:int;//特效播放需要的ID
private var effectIntervalId15:int;//特效播放需要的ID
private var effectIntervalId16:int;//特效播放需要的ID
private var effectIntervalId17:int;//特效播放需要的ID
private var effectIntervalId18:int;//特效播放需要的ID
private var effectIntervalId19:int;//特效播放需要的ID
private var effectIntervalId20:int;//特效播放需要的ID
private var effectIntervalId21:int;//特效播放需要的ID
private var effectIntervalId22:int;//特效播放需要的ID
private var effectIntervalId23:int;//特效播放需要的ID
private var effectIntervalId24:int;//特效播放需要的ID

private const BUFF_INTERVAL_ID_STR:String = "buffIntervalId";
private var buffIntervalId1:int;//buff延时需要的ID
private var buffIntervalId2:int;//buff延时需要的ID
private var buffIntervalId3:int;//buff延时需要的ID

private var attackIntervalId:int;//攻击时需要的ID

private const DEFENSE_INTERVAL_ID_STR:String = "defenseIntervalId";
private var defenseIntervalId1:int;//防御时需要的ID
private var defenseIntervalId2:int;//防御时需要的ID
private var defenseIntervalId3:int;//防御时需要的ID
private var defenseIntervalId4:int;//防御时需要的ID

private var counterHitIntervalId1:int;//反击时需要的ID
private var counterHitIntervalId2:int;//反击时需要的ID

private const VIBRATE_INTERVAL_ID_STR:String = "vibrateIntervalId";
private var vibrateIntervalId1:int;//屏幕震动的setTimeoutId
private var vibrateIntervalId2:int;//屏幕震动的setTimeoutId
private var vibrateIntervalId3:int;//屏幕震动的setTimeoutId
private var vibrateIntervalId4:int;//屏幕震动的setTimeoutId
