--魔法都市エンディミオン
--Magical Citadel of Endymion
function c39910367.initial_effect(c)
	c:EnableCounterPermit(COUNTER_SPELL)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Add counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_FZONE)
	e2:SetOperation(c39910367.op)
	c:RegisterEffect(e2)
	--Remove counter replace
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc39910367(c39910367,0))
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_RCOUNTER_REPLACE+COUNTER_SPELL)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c39910367.rcon)
	e3:SetOperation(c39910367.rop)
	c:RegisterEffect(e3)
	--Destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTarget(c39910367.desreptg)
	e4:SetOperation(c39910367.desrepop)
	c:RegisterEffect(e4)
	--Add counter2
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e5:SetCode(EVENT_LEAVE_FIELD_P)
	e5:SetRange(LOCATION_FZONE)
	e5:SetOperation(c39910367.addop2)
	c:RegisterEffect(e5)
end
c39910367.listed_names={c39910367}
c39910367.counter_place_list={COUNTER_SPELL}
function c39910367.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=re:GetHandler()
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and rc~=c then
		c:AddCounter(COUNTER_SPELL,1)
	end
end
function c39910367.rcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (r&REASON_COST)~=0 and re:IsActivated() and ep==e:GetOwnerPlayer() and c:GetCounter(COUNTER_SPELL)>=ev
		and re:GetHandler()~=c
end
function c39910367.rop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(ep,COUNTER_SPELL,ev,REASON_EFFECT)
end
function c39910367.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsReason(REASON_REPLACE+REASON_RULE)
		and e:GetHandler():GetCounter(COUNTER_SPELL)>0 end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c39910367.desrepop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(ep,COUNTER_SPELL,1,REASON_EFFECT)
end
function c39910367.addop2(e,tp,eg,ep,ev,re,r,rp)
	local count=0
	for c in aux.Next(eg) do
		if not c:IsCode(c39910367) and c:IsLocation(LOCATION_ONFIELD) and c:IsReason(REASON_DESTROY) then
			count=count+c:GetCounter(COUNTER_SPELL)
		end
	end
	if count>0 then
		e:GetHandler():AddCounter(COUNTER_SPELL,count)
	end
end