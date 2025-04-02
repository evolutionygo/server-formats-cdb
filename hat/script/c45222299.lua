--イビリチュア・ガストクラーケ
--Evigishki Gustkraken
function c45222299.initial_effect(c)
	c:EnableReviveLimit()
	--Reveal and shuffle cards into the Deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc45222299(c45222299,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c45222299.condition)
	e1:SetTarget(c45222299.target)
	e1:SetOperation(c45222299.operation)
	c:RegisterEffect(e1)
end
c45222299.listed_series={0x3a}
function c45222299.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL)
end
function c45222299.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,0,LOCATION_HAND)
end
function c45222299.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if #g==0 then return end
	local ct=1
	if #g>1 then ct=Duel.AnnounceNumber(tp,1,2) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	g=g:RandomSelect(tp,ct)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=g:Select(tp,1,1,nil)
	Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
	Duel.ShuffleHand(1-tp)
end