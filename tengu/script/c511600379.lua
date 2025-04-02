--ジョーズマン (Anime)
--Jawsman (Anime)
function c511600379.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c511600379.atkup)
	c:RegisterEffect(e1)
end
function c511600379.atkup(e,c)
	return Duel.GetMatchingGroupCount(aux.FaceupFilter(Card.IsAttribute,ATTRIBUTE_WATER),c:GetControler(),LOCATION_MZONE,0,c)*300
end