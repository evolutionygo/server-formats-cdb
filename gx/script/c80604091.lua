--血の代償
--Ultimate Offering
function c80604091.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--instant
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc80604091(c80604091,0))
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c80604091.condition)
	e2:SetCost(c80604091.cost)
	e2:SetTarget(c80604091.target)
	e2:SetOperation(c80604091.activate)
	c:RegisterEffect(e2)
end
function c80604091.condition(e,tp,eg,ep,ev,re,r,rp)
	local tn=Duel.GetTurnPlayer()
	return (tn==tp and Duel.IsMainPhase()) or (tn~=tp and Duel.IsBattlePhase())
end
function c80604091.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	if e:GetHandler():GetFlagEffect(c80604091)==0 then
		e:GetHandler():RegisterFlagEffect(c80604091,RESET_CHAIN,0,1,Duel.GetMatchingGroupCount(Card.CanSummonOrSet,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,true,nil))
	end
	Duel.PayLPCost(tp,500)
end
function c80604091.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetHandler():GetFlagEffect(c80604091)==0 then
			return Duel.GetMatchingGroupCount(Card.CanSummonOrSet,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,true,nil)>0
		else return e:GetHandler():GetFlagEffectLabel(c80604091)>0 end
	end
	e:GetHandler():SetFlagEffectLabel(c80604091,e:GetHandler():GetFlagEffectLabel(c80604091)-1)
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c80604091.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local tc=Duel.SelectMatchingCard(tp,Card.CanSummonOrSet,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,true,nil):GetFirst()
	if tc then
		Duel.SummonOrSet(tp,tc,true,nil)
	end
end