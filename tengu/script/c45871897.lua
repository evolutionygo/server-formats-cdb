--ロストガーディアン
--Lost Guardian
function c45871897.initial_effect(c)
	--change defense
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_DEFENSE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c45871897.defval)
	c:RegisterEffect(e1)
end
function c45871897.defval(e,c)
	return Duel.GetMatchingGroupCount(aux.FaceupFilter(Card.IsRace,RACE_ROCK),c:GetControler(),LOCATION_REMOVED,0,nil)*700
end