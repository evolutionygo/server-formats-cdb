--セイクリッド・シェラタン
--Constellar Sheratan
function c78486968.initial_effect(c)
	--Add 1 "Constellar" monster from the Deck to the hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc78486968(c78486968,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c78486968.tg)
	e1:SetOperation(c78486968.op)
	c:RegisterEffect(e1,false,REGISTER_FLAG_TELLAR)
end
c78486968.listed_series={SET_CONSTELLAR}
function c78486968.filter(c)
	return c:IsSetCard(SET_CONSTELLAR) and c:IsMonster() and c:IsAbleToHand()
end
function c78486968.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	--Excluding itself for a proper interaction with "Tellarknight Constellar Caduceus" [58858807]
	if chk==0 then return Duel.IsExistingMatchingCard(c78486968.filter,tp,LOCATION_DECK,0,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c78486968.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c78486968.filter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end