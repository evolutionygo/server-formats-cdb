--魔力枯渇
--Exhausting Spell
function c95451366.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95451366.target)
	e1:SetOperation(c95451366.activate)
	c:RegisterEffect(e1)
end
c95451366.counter_list={COUNTER_SPELL}
function c95451366.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,1,COUNTER_SPELL,1,REASON_EFFECT) end
end
function c95451366.filter(c)
	return c:IsFaceup() and c:GetCounter(COUNTER_SPELL)~=0
end
function c95451366.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c95451366.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	for tc in aux.Next(g) do 
		local cc=tc:GetCounter(COUNTER_SPELL)
		tc:RemoveCounter(tp,COUNTER_SPELL,cc,REASON_EFFECT)
	end
end