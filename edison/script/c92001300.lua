--古代の機械城
--Ancient Gear Castle
function c92001300.initial_effect(c)
	c:EnableCounterPermit(0xb)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x7))
	e2:SetValue(300)
	c:RegisterEffect(e2)
	--counter
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c92001300.addc)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_MSET)
	c:RegisterEffect(e4)
	--summon proc
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(c92001300)
	c:RegisterEffect(e3)
	aux.GlobalCheck(s,function()
		--summon proc
		local ge1=Effect.CreateEffect(c)
		ge1:SetDescription(aux.Stringc92001300(c92001300,0))
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_SUMMON_PROC)
		ge1:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
		ge1:SetCondition(c92001300.sumcon)
		ge1:SetTarget(aux.FieldSummonProcTg(aux.TargetBoolFunction(Card.IsSetCard,0x7),c92001300.sumtg))
		ge1:SetOperation(c92001300.sumop)
		ge1:SetValue(SUMMON_TYPE_TRIBUTE)
		Duel.RegisterEffect(ge1,0)
	end)
end
c92001300.listed_series={0x7}
function c92001300.addc(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0xb,1)
end
function c92001300.castlefilter(c,tp,mi,ma)
	return c:IsHasEffect(c92001300) and c:GetCounter(0xb)>=mi and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsReleasable()
end
function c92001300.sumcon(e,c,minc)
	if c==nil then return true end
	local mi,ma=c:GetTributeRequirement()
	if mi<minc then mi=minc end
	if ma<mi then return false end
	return ma>0 and Duel.IsExistingMatchingCard(c92001300.castlefilter,c:GetControler(),LOCATION_SZONE,0,1,nil,c:GetControler(),mi,ma)
end
function c92001300.sumtg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	tp=c:GetControler()
	local mi,ma=c:GetTributeRequirement()
	local sg=Duel.SelectMatchingCard(tp,c92001300.castlefilter,tp,LOCATION_SZONE,0,1,1,true,nil,tp,mi,ma)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	end
	return false
end
function c92001300.sumop(e,tp,eg,ep,ev,re,r,rp,c)
	local sg=e:GetLabelObject()
	if not sg then return end
	Duel.Release(sg,REASON_COST)
	sg:DeleteGroup()
end