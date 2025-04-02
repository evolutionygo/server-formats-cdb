--魂粉砕
--Soul Demolition
function c76297408.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc76297408(c76297408,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c76297408.rmcon)
	e2:SetCost(c76297408.rmcost)
	e2:SetTarget(c76297408.rmtg)
	e2:SetOperation(c76297408.rmop)
	c:RegisterEffect(e2)
end
function c76297408.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsRace,RACE_FIEND),tp,LOCATION_MZONE,0,1,nil)
end
function c76297408.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c76297408.rfilter(c)
	return c:IsMonster() and c:IsAbleToRemove() and aux.SpElimFilter(c)
end
function c76297408.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c76297408.rfilter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,nil)
		and Duel.IsExistingTarget(c76297408.rfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectTarget(tp,c76297408.rfilter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_REMOVE)
	local g2=Duel.SelectTarget(1-tp,c76297408.rfilter,1-tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g1,#g1,0,0)
end
function c76297408.rmop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetTargetCards(e)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end