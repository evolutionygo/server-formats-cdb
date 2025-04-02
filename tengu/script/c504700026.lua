--滅びの爆裂疾風弾
--Burst Stream of Destruction (GOAT)
--If effect is negated, restriction doesn't apply
--If monsters are immuned, restruction doesn't apply
function c504700026.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c504700026.condition)
	e1:SetCost(c504700026.cost)
	e1:SetTarget(c504700026.target)
	e1:SetOperation(c504700026.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(c504700026,ACTIVITY_ATTACK,c504700026.counterfilter)
end
c504700026.listed_names={CARD_BLUEEYES_W_DRAGON}
function c504700026.counterfilter(c)
	return not c:IsCode(CARD_BLUEEYES_W_DRAGON)
end
function c504700026.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,CARD_BLUEEYES_W_DRAGON),tp,LOCATION_ONFIELD,0,1,nil)
end
function c504700026.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(c504700026,tp,ACTIVITY_ATTACK)==0 end
end
function c504700026.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true or Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,#sg,0,0)
end
function c504700026.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsCode,CARD_BLUEEYES_W_DRAGON))
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e2:SetDescription(aux.Stringc504700026(c504700026,1))
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetTargetRange(1,0)
	Duel.RegisterEffect(e2,tp)
end