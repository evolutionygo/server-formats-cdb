--D－HERO ドグマガイ
--Destiny HERO - Dogma
function c17132130.initial_effect(c)
	c:EnableReviveLimit()
	--Special Summon limitation
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--Special Summon procedure
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc17132130(c17132130,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetValue(1)
	e2:SetCondition(c17132130.spcon)
	e2:SetTarget(c17132130.sptg)
	e2:SetOperation(c17132130.spop)
	c:RegisterEffect(e2)
	--Register flga when sucessfully summoned
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c17132130.lp)
	e3:SetOperation(c17132130.lpop)
	c:RegisterEffect(e3)
end
c17132130.listed_series={0xc008}
function c17132130.spfilter(c,tp)
	return c:IsSetCard(0xc008) and (c:IsControler(tp) or c:IsFaceup())
end
function c17132130.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local rg1=Duel.GetReleaseGroup(tp)
	local rg2=Duel.GetMatchingGroup(c17132130.spfilter,tp,LOCATION_MZONE,0,nil,tp)
	return aux.SelectUnselectGroup(rg1,e,tp,3,3,aux.ChkfMMZ(1),0)
		and aux.SelectUnselectGroup(rg2,e,tp,1,1,aux.ChkfMMZ(1),0)
end
function c17132130.sptg(e,tp,eg,ep,ev,re,r,rp,c)
	local rg1=Duel.GetMatchingGroup(c17132130.spfilter,tp,LOCATION_MZONE,0,nil,tp)
	local mg1=aux.SelectUnselectGroup(rg1,e,tp,1,1,aux.ChkfMMZ(1),1,tp,HINTMSG_RELEASE,nil,nil,true)
	if #mg1>0 then
		local sg=mg1:GetFirst()
		local rg2=Duel.GetReleaseGroup(tp)
		rg2:RemoveCard(sg)
		local mg2=aux.SelectUnselectGroup(rg2,e,tp,2,2,aux.ChkfMMZ(1),1,tp,HINTMSG_RELEASE,nil,nil,true)
		mg1:Merge(mg2)
	end
	if #mg1==3 then
		mg1:KeepAlive()
		e:SetLabelObject(mg1)
		return true
	end
	return false
end
function c17132130.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.Release(g,REASON_COST)
	g:DeleteGroup()
end
function c17132130.lp(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c17132130.lpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc17132130(c17132130,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_EVENT|(RESETS_STANDARD|RESET_CONTROL)&~RESET_TOFIELD|RESET_PHASE|PHASE_STANDBY)
	e1:SetCondition(c17132130.lpc)
	e1:SetOperation(c17132130.lpcop)
	c:RegisterEffect(e1)
end
function c17132130.lpc(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsTurnPlayer(1-tp)
end
function c17132130.lpcop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(1-tp,Duel.GetLP(1-tp)/2)
end