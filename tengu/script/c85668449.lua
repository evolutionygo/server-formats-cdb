--脳開発研究所
--Brain Research Lab
function c85668449.initial_effect(c)
	c:EnableCounterPermit(0x4)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_FZONE)
	e2:SetDescription(aux.Stringc85668449(c85668449,0))
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,LOCATION_HAND+LOCATION_MZONE)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_PSYCHIC))
	e2:SetOperation(c85668449.esop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCondition(c85668449.ctcon)
	e3:SetOperation(c85668449.ctop)
	c:RegisterEffect(e3)
	--LP Cost replace
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc85668449(c85668449,1))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EFFECT_LPCOST_REPLACE)
	e4:SetCondition(c85668449.lrcon)
	e4:SetOperation(c85668449.lrop)
	c:RegisterEffect(e4)
	--Inflict Damage
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_LEAVE_FIELD_P)
	e5:SetOperation(c85668449.damp)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_LEAVE_FIELD)
	e6:SetOperation(c85668449.damop)
	e6:SetLabelObject(e5)
	c:RegisterEffect(e6)
end
c85668449.counter_list={0x4}
function c85668449.esop(e,tp,eg,ep,ev,re,r,rp,c)
	c:RegisterFlagEffect(c85668449,RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END,0,1)
end
function c85668449.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():GetFlagEffect(c85668449)~=0
end
function c85668449.ctop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x4,1)
	eg:GetFirst():ResetFlagEffect(c85668449)
end
function c85668449.lrcon(e,tp,eg,ep,ev,re,r,rp)
	if tp~=ep then return false end
	if Duel.GetLP(ep)<ev then return false end
	if not (re and re:IsActivated()) then return false end
	local rc=re:GetHandler()
	return rc:IsLocation(LOCATION_MZONE) and rc:IsRace(RACE_PSYCHIC)
end
function c85668449.lrop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x4,1)
end
function c85668449.damp(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetCounter(0x4)
	e:SetLabel(ct)
end
function c85668449.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabelObject():GetLabel()
	if ct>0 then
		Duel.Damage(tp,ct*1000,REASON_EFFECT)
	end
end