--海底に潜む深海竜
--The Dragon Dwelling in the Deep
function c4404099.initial_effect(c)
	c:EnableCounterPermit(0x23)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc4404099(c4404099,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetTarget(c4404099.addct)
	e1:SetOperation(c4404099.addc)
	c:RegisterEffect(e1)
	--register before leaving
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD_P)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetOperation(c4404099.regop)
	c:RegisterEffect(e2)
	--increase ATK
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc4404099(c4404099,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c4404099.atkcon)
	e3:SetOperation(c4404099.atkop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
c4404099.counter_list={0x23}
function c4404099.addct(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x23)
end
function c4404099.addc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x23,1)
	end
end
function c4404099.regop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetCounter(0x23)
	e:SetLabel(ct)
end
function c4404099.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabelObject():GetLabel()
	e:SetLabel(ct)
	return ct>0 and not e:GetHandler():IsLocation(LOCATION_DECK)
end
function c4404099.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.FaceupFilter(Card.IsRace,RACE_FISH+RACE_SEASERPENT),tp,LOCATION_MZONE,0,nil)
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel()*200)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end