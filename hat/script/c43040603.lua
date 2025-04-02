--モンスターゲート
--Monster Gate
function c43040603.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc43040603(c43040603,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c43040603.cost)
	e1:SetTarget(c43040603.target)
	e1:SetOperation(c43040603.operation)
	c:RegisterEffect(e1)
end
function c43040603.cfilter(c,tp)
	return Duel.GetMZoneCount(tp,c)>0
end
function c43040603.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,c43040603.cfilter,1,false,nil,nil,tp) end
	local g=Duel.SelectReleaseGroupCost(tp,c43040603.cfilter,1,1,false,nil,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c43040603.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (e:GetLabel()==1 or Duel.GetLocationCount(tp,LOCATION_MZONE)>0) and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(Card.IsSummonableCard,tp,LOCATION_DECK,0,1,nil) and Duel.IsPlayerCanDiscardDeck(tp,1)
		and not Duel.IsPlayerAffectedByEffect(tp,CARD_EHERO_BLAZEMAN) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
	Duel.SetPossibleOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c43040603.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanSpecialSummon(tp) or not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	local g=Duel.GetMatchingGroup(Card.IsSummonableCard,tp,LOCATION_DECK,0,nil)
	local dcount=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	local seq=-1
	local tc=g:GetFirst()
	local spcard=nil
	for tc in aux.Next(g) do
		if tc:GetSequence()>seq then 
			seq=tc:GetSequence()
			spcard=tc
		end
	end
	if seq==-1 then
		Duel.ConfirmDecktop(tp,dcount)
		Duel.ShuffleDeck(tp)
		return
	end
	Duel.ConfirmDecktop(tp,dcount-seq)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and spcard:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.DisableShuffleCheck()
		if dcount-seq==1 then Duel.SpecialSummon(spcard,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.SpecialSummonStep(spcard,0,tp,tp,false,false,POS_FACEUP)
			Duel.DiscardDeck(tp,dcount-seq-1,REASON_EFFECT)
			Duel.SpecialSummonComplete()
		end
	else
		Duel.DiscardDeck(tp,dcount-seq,REASON_EFFECT)
	end
end