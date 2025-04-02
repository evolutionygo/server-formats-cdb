--リチュア・ノエリア
--Gishki Noellia
function c63942761.initial_effect(c)
	--Mill
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc63942761(c63942761,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c63942761.target)
	e1:SetOperation(c63942761.operation)
	c:RegisterEffect(e1)
end
c63942761.listed_series={SET_GISHKI}
function c63942761.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,5) end
end
function c63942761.filter(c)
	return c:IsRitualSpell() or (c:IsSetCard(SET_GISHKI) and c:IsMonster())
end
function c63942761.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,5) then return end
	Duel.ConfirmDecktop(tp,5)
	local g=Duel.GetDecktopGroup(tp,5)
	local sg=g:Filter(c63942761.filter,nil)
	if #sg>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(sg,REASON_EFFECT|REASON_EXCAVATE)
	end
	Duel.MoveToDeckBottom(5-#sg,tp)
	Duel.SortDeckbottom(tp,tp,5-#sg)
end