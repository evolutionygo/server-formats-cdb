--サンライト・ユニコーン
--Sunlight Unicorn
function c10321588.initial_effect(c)
	--Excavate the top card of your Deck and add it to the hand if it is an Equip Spell Card
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc10321588(c10321588,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c10321588.target)
	e1:SetOperation(c10321588.operation)
	c:RegisterEffect(e1)
end
function c10321588.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetDecktopGroup(tp,1)
	if chk==0 then return #g>0 and g:GetFirst():IsAbleToHand() end
	Duel.SetPossibleOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c10321588.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsEquipSpell() then
		Duel.DisableShuffleCheck()
		if tc:IsAbleToHand() then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ShuffleHand(tp)
		else
			Duel.SendtoGrave(tc,REASON_RULE)
		end
	else
		Duel.MoveSequence(tc,SEQ_DECKBOTTOM)
	end
end