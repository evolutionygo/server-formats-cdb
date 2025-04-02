--トゥーン・ドラゴン・エッガー
--Manga Ryu-Ran (GOAT)
--Basically pre errata
function c504700062.initial_effect(c)
	--sum limit
	c:EnableReviveLimit()
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c504700062.spcon)
	e2:SetTarget(c504700062.sptg)
	e2:SetOperation(c504700062.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c504700062.sdescon)
	e3:SetOperation(c504700062.sdesop)
	c:RegisterEffect(e3)
	--direct attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DIRECT_ATTACK)
	e4:SetCondition(c504700062.dircon)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e5:SetCondition(c504700062.atcon)
	e5:SetValue(c504700062.atlimit)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e6:SetCondition(c504700062.atcon)
	c:RegisterEffect(e6)
	--cannot attack
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_SPSUMMON_SUCCESS)
	e7:SetOperation(c504700062.atklimit)
	c:RegisterEffect(e7)
	--attack cost
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_ATTACK_COST)
	e8:SetCost(c504700062.atcost)
	e8:SetOperation(c504700062.atop)
	c:RegisterEffect(e8)
end
c504700062.listed_names={15259703}
function c504700062.cfilter(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c504700062.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	if not Duel.IsExistingMatchingCard(c504700062.cfilter,tp,LOCATION_ONFIELD,0,1,nil) then return false end
	local lv=c:GetLevel()
	local amt=(lv>6 and 2) or (lv>4 and 1) or 0
	return amt==0 or Duel.CheckReleaseGroup(tp,nil,amt,false,amt,true,c,nil,nil,false,nil)
end
function c504700062.sptg(e,tp,eg,ep,ev,re,r,rp,c)
	local c=e:GetHandler()
	local lv=c:GetLevel()
	local amt=(lv>6 and 2) or (lv>5 and 1) or 0
	if amt==0 then return true end
	local g=Duel.SelectReleaseGroup(c:GetControler(),nil,amt,amt,false,true,true,c,nil,nil,false,nil)
	if not g then return false end
	g:KeepAlive()
	e:SetLabelObject(g)
	return true
end
function c504700062.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if g then
		Duel.Release(g,REASON_COST)
		g:DeleteGroup()
	end
end
function c504700062.sfilter(c)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==15259703 and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c504700062.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c504700062.sfilter,1,nil)
end
function c504700062.sdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c504700062.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c504700062.dircon(e)
	return not Duel.IsExistingMatchingCard(c504700062.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c504700062.atcon(e)
	return Duel.IsExistingMatchingCard(c504700062.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c504700062.atlimit(e,c)
	return not c:IsType(TYPE_TOON) or c:IsFacedown()
end
function c504700062.atklimit(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c504700062.atcost(e,c,tp)
	return Duel.CheckLPCost(tp,500)
end
function c504700062.atop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsAttackCostPac504700062()~=2 and e:GetHandler():IsLocation(LOCATION_MZONE) then
		Duel.PayLPCost(tp,500)
		Duel.AttackCostPac504700062()
	end
end