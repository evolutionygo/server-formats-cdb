--エクシーズ・ブロック (Anime)
--Xyz Block (Anime)
function c511600386.initial_effect(c)
	--Negate an effect activated by the opponent
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511600386(c511600386,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511600386.condition)
	e1:SetTarget(c511600386.target)
	e1:SetOperation(c511600386.activate)
	c:RegisterEffect(e1)
end
function c511600386.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and Duel.IsChainDisablable(ev)
end
function c511600386.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckRemoveOverlayCard(tp,1,0,1,REASON_EFFECT) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c511600386.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.RemoveOverlayCard(tp,1,0,1,1,REASON_EFFECT)>0 then
		Duel.NegateEffect(ev)
	end
end