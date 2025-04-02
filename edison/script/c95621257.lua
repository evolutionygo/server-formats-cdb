--フレムベル・マジカル
--Flamvell Magician
function c95621257.initial_effect(c)
	--Gain 400 ATK if you control an "Ally of Justice" monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c95621257.atkcon)
	e1:SetValue(400)
	c:RegisterEffect(e1)
end
c95621257.listed_series={SET_ALLY_OF_JUSTICE}
function c95621257.atkcon(e)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSetCard,SET_ALLY_OF_JUSTICE),e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil)
end