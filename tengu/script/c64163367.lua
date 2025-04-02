--「A」細胞培養装置
--"A" Cell Incubator
function c64163367.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--counter1
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_REMOVE_COUNTER+COUNTER_A)
	e2:SetOperation(c64163367.ctop1)
	c:RegisterEffect(e2)
	--register before leaving
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_LEAVE_FIELD_P)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetOperation(c64163367.regop)
	c:RegisterEffect(e3)
	--place counters when leaving
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc64163367(c64163367,0))
	e4:SetCategory(CATEGORY_COUNTER)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(c64163367.ctcon2)
	e4:SetOperation(c64163367.ctop2)
	e4:SetLabelObject(e3)
	c:RegisterEffect(e4)
end
c64163367.counter_place_list={COUNTER_A}
function c64163367.ctop1(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(COUNTER_NEED_ENABLE+COUNTER_A,1)
end
function c64163367.regop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetCounter(COUNTER_A)
	e:SetLabel(ct)
end
function c64163367.ctcon2(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabelObject():GetLabel()
	e:SetLabel(ct)
	return ct>0
end
function c64163367.ctop2(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if #g==0 then return end
	for i=1,ct do
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringc64163367(c64163367,1))
		local sg=g:Select(tp,1,1,nil)
		sg:GetFirst():AddCounter(COUNTER_A,1)
	end
end