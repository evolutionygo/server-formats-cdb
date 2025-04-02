--フォース・リリース
--Unleash Your Power!
function c73567374.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c73567374.target)
	e1:SetOperation(c73567374.operation)
	c:RegisterEffect(e1)
end
c73567374.listed_card_types={TYPE_GEMINI}
function c73567374.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_GEMINI) and not c:IsGeminiStatus()
end
function c73567374.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c73567374.filter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return #g>0 end
	Duel.SetTargetCard(g)
end
function c73567374.filter2(c,e)
	return c73567374.filter(c) and not c:IsImmuneToEffect(e)
end
function c73567374.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetTargetCards(e):Match(c73567374.filter2,nil,e)
	if #g==0 then return end
	g:ForEach(Card.EnableGeminiStatus)
	aux.DelayedOperation(g,PHASE_END,c73567374,e,tp,function(ag) Duel.ChangePosition(ag,POS_FACEDOWN_DEFENSE) end)
end