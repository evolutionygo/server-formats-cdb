--大革命
--Huge Revolution
function c65396880.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc65396880(c65396880,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c65396880.condition)
	e1:SetTarget(c65396880.target)
	e1:SetOperation(c65396880.activate)
	c:RegisterEffect(e1)
end
c65396880.listed_names={12143771,58538870,85936485} --"People Running About", "Oppressed People", "United Resistance"
function c65396880.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsTurnPlayer(tp) and Duel.IsMainPhase()
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,12143771),tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,58538870),tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,85936485),tp,LOCATION_ONFIELD,0,1,nil)
end
function c65396880.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local desg=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)
	if chk==0 then return #desg>0 or Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0,LOCATION_HAND,1,nil) end
	local hg=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,0,LOCATION_HAND,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,hg,#hg,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,desg,#desg,tp,0)
end
function c65396880.activate(e,tp,eg,ep,ev,re,r,rp)
	local hg=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,0,LOCATION_HAND,nil)
	if #hg>0 then
		Duel.SendtoGrave(hg,REASON_EFFECT)
	end
	local desg=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)
	if #desg>0 then
		Duel.Destroy(desg,REASON_EFFECT)
	end
end