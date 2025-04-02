--トゥーンのかばん (Anime)
--Toon Briefcase (Anime)
function c511000629.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c511000629.condition)
	e1:SetTarget(c511000629.target)
	e1:SetOperation(c511000629.activate)
	c:RegisterEffect(e1)
end
c511000629.listed_names={15259703}
function c511000629.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,15259703),tp,LOCATION_ONFIELD,0,1,nil)
end
function c511000629.filter(c,p)
	return c:IsSummonPlayer(p) and c:IsAbleToDeck() and c:IsLocation(LOCATION_MZONE)
end
function c511000629.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511000629.filter,1,nil,1-tp) end
	local g=eg:Filter(c511000629.filter,nil,1-tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,#g,0,0)
end
function c511000629.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetTargetCards(e):Filter(Card.IsRelateToEffect,nil,e)
	if #g>0 then
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end