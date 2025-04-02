--エヴォルカイザー・ラギア
--Evolzar Laggia
function c74294676.initial_effect(c)
	--Xyz Summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunctionEx(Card.IsRace,RACE_DINOSAUR),4,2)
	c:EnableReviveLimit()
	--Negate activation
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc74294676(c74294676,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c74294676.condition1)
	e1:SetCost(aux.dxmcostgen(2,2,nil))
	e1:SetTarget(c74294676.target1)
	e1:SetOperation(c74294676.operation1)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
	--Negate Normal Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc74294676(c74294676,1))
	e2:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_SUMMON)
	e2:SetCondition(c74294676.condition2)
	e2:SetCost(aux.dxmcostgen(2,2,nil))
	e2:SetTarget(c74294676.target2)
	e2:SetOperation(c74294676.operation2)
	c:RegisterEffect(e2,false,REGISTER_FLAG_DETACH_XMAT)
	--Negate Special Summon
	local e3=e2:Clone()
	e3:SetDescription(aux.Stringc74294676(c74294676,2))
	e3:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e3,false,REGISTER_FLAG_DETACH_XMAT)
	aux.DoubleSnareValc74294676ity(c,LOCATION_MZONE)
end
function c74294676.condition1(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c74294676.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	local rc=re:GetHandler()
	if rc:IsDestructable() and rc:IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c74294676.operation1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c74294676.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0
end
function c74294676.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,#eg,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,#eg,0,0)
end
function c74294676.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end