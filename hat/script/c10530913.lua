--森羅の賢樹 シャーマン
--Sylvan Sagequoia
function c10530913.initial_effect(c)
	--Special Summon itself from the hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc10530913(c10530913,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c10530913.spcon)
	e1:SetTarget(c10530913.sptg)
	e1:SetOperation(c10530913.spop)
	c:RegisterEffect(e1)
	--Excavate the top card of Deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc10530913(c10530913,1))
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c10530913.target)
	e2:SetOperation(c10530913.operation)
	c:RegisterEffect(e2)
	--Add 1 card "Sylvan" Spell/Trap to the hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc10530913(c10530913,2))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c10530913.thcon)
	e3:SetTarget(c10530913.thtg)
	e3:SetOperation(c10530913.thop)
	c:RegisterEffect(e3)
end
c10530913.listed_series={SET_SYLVAN}
function c10530913.cfilter(c)
	return c:IsSetCard(SET_SYLVAN) and c:IsMonster()
end
function c10530913.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c10530913.cfilter,1,nil)
end
function c10530913.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c10530913.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c10530913.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c10530913.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsRace(RACE_PLANT) then
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(g,REASON_EFFECT|REASON_EXCAVATE)
	else
		Duel.MoveSequence(tc,1)
	end
end
function c10530913.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_DECK) and c:IsReason(REASON_EXCAVATE)
end
function c10530913.thfilter(c)
	return c:IsSetCard(SET_SYLVAN) and c:IsSpellTrap() and c:IsAbleToHand()
end
function c10530913.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c10530913.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c10530913.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c10530913.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c10530913.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end