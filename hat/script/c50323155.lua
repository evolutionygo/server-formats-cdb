--昇天の黒角笛
--Black Horn of Heaven
function c50323155.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c50323155.condition)
	e1:SetTarget(c50323155.target)
	e1:SetOperation(c50323155.activate)
	c:RegisterEffect(e1)
end
function c50323155.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-tp and #eg==1 and Duel.GetCurrentChain(true)==0
end
function c50323155.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,#eg,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,#eg,0,0)
end
function c50323155.activate(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end