--脳開発研究所 (Action Field)
--Brain Research Lab (Action Field)
function c151000005.initial_effect(c)
	c:EnableCounterPermit(0x4)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_FZONE)
	e2:SetDescription(aux.Stringc151000005(c151000005,0))
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,LOCATION_HAND+LOCATION_MZONE)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_PSYCHIC))
	e2:SetOperation(c151000005.esop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCondition(c151000005.ctcon)
	e3:SetOperation(c151000005.ctop)
	c:RegisterEffect(e3)
	--lpcost replace
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc151000005(c151000005,1))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EFFECT_LPCOST_REPLACE)
	e4:SetCondition(c151000005.lrcon)
	e4:SetOperation(c151000005.lrop)
	c:RegisterEffect(e4)
	--damage
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_LEAVE_FIELD_P)
	e5:SetOperation(c151000005.damp)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_LEAVE_FIELD)
	e6:SetOperation(c151000005.damop)
	e6:SetLabelObject(e5)
	c:RegisterEffect(e6)
end
c151000005.af="a"
c151000005.counter_list={0x4}
function c151000005.esop(e,tp,eg,ep,ev,re,r,rp,c)
	c:RegisterFlagEffect(c151000005,RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END,0,1)
end
function c151000005.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():GetFlagEffect(c151000005)~=0
end
function c151000005.ctop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x4,1)
	eg:GetFirst():ResetFlagEffect(c151000005)
end
function c151000005.lrcon(e,tp,eg,ep,ev,re,r,rp)
	if tp~=ep then return false end
	local lp=Duel.GetLP(ep)
	if lp<ev then return false end
	if not re or not re:IsHasType(0x7e0) then return false end
	local rc=re:GetHandler()
	return rc:IsLocation(LOCATION_MZONE) and rc:IsRace(RACE_PSYCHIC)
end
function c151000005.lrop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x4,1)
end
function c151000005.damp(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetCounter(0x4)
	e:SetLabel(ct)
end
function c151000005.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabelObject():GetLabel()
	if ct>0 then
		Duel.Damage(tp,ct*1000,REASON_EFFECT)
	end
end