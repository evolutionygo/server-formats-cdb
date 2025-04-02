--E・HERO ザ・ヒート
function c98266377.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c98266377.val)
	c:RegisterEffect(e1)
end
c98266377.listed_series={0x3008}
function c98266377.val(e,c)
	return Duel.GetMatchingGroupCount(aux.FaceupFilter(Card.IsSetCard,0x3008),c:GetControler(),LOCATION_MZONE,0,nil)*200
end