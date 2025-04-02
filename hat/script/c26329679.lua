--セイクリッド・オメガ
--Constellar Omega
function c26329679.initial_effect(c)
	--Must be properly summoned before reviving
	c:EnableReviveLimit()
	--Xyz summon procedure
	aux.AddXyzProcedure(c,aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_LIGHT),4,2)
	--All your "Constellar" become unaffected by spells/traps
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc26329679(c26329679,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c26329679.cost)
	e1:SetOperation(c26329679.operation)
	e1:SetHintTiming(TIMING_STANDBY_PHASE+TIMING_END_PHASE)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
end
c26329679.listed_series={0x53}
function c26329679.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c26329679.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.FaceupFilter(Card.IsSetCard,0x53),tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		--Unaffected by spells/traps
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(3104)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(c26329679.efilter)
		tc:RegisterEffect(e1)
	end
end
function c26329679.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end