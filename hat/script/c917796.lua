--ガガガタッグ
--Gagagatag
function c917796.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,c917796,EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c917796.target)
	e1:SetOperation(c917796.activate)
	c:RegisterEffect(e1)
end
c917796.listed_series={0x54}
function c917796.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSetCard,0x54),tp,LOCATION_MZONE,0,1,nil) end
end
function c917796.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.FaceupFilter(Card.IsSetCard,0x54),tp,LOCATION_MZONE,0,nil)
	local atk=#sg*500
	local c=e:GetHandler()
	local tc=sg:GetFirst()
	for tc in aux.Next(sg) do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_STANDBY,2)
		tc:RegisterEffect(e1)
	end
end