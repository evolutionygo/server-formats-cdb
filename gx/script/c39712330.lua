--決戦の火蓋
--Cry Havoc!
function c39712330.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--instant
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc39712330(c39712330,0))
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c39712330.condition)
	e2:SetCost(c39712330.cost)
	e2:SetTarget(c39712330.target)
	e2:SetOperation(c39712330.activate)
	c:RegisterEffect(e2)
end
function c39712330.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsTurnPlayer(tp) and Duel.IsMainPhase()
end
function c39712330.cfilter(c)
	return c:IsMonster() and c:IsAbleToRemoveAsCost() and aux.SpElimFilter(c)
end
function c39712330.filter(c)
	return c:IsType(TYPE_NORMAL) and c:CanSummonOrSet(true,nil)
end
function c39712330.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c39712330.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil) end
	if e:GetHandler():GetFlagEffect(c39712330)==0 then
		e:GetHandler():RegisterFlagEffect(c39712330,RESET_CHAIN,0,1,Duel.GetMatchingGroupCount(c39712330.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,nil))
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c39712330.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c39712330.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetHandler():GetFlagEffect(c39712330)==0 then
			return Duel.GetMatchingGroupCount(c39712330.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)>0
		else return e:GetHandler():GetFlagEffectLabel(c39712330)>0 end
	end
	e:GetHandler():SetFlagEffectLabel(c39712330,e:GetHandler():GetFlagEffectLabel(c39712330)-1)
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c39712330.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local tc=Duel.SelectMatchingCard(tp,c39712330.filter,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	if tc then
		Duel.SummonOrSet(tp,tc,true,nil)
	end
end