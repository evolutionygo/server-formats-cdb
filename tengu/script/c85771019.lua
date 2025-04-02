--堕天使アスモディウス
--Darklord Asmodeus
function c85771019.initial_effect(c)
	--Special Summon condition
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetRange(LOCATION_DECK+LOCATION_GRAVE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--Send 1 Fairy from your Deck to the GY
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc85771019(c85771019,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c85771019.tgtg)
	e2:SetOperation(c85771019.tgop)
	c:RegisterEffect(e2)
	--Special Summon 1 "Asmo Token" and 1 "Deus Token"
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc85771019(c85771019,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c85771019.spcon)
	e3:SetTarget(c85771019.sptg)
	e3:SetOperation(c85771019.spop)
	c:RegisterEffect(e3)
end
c85771019.listed_names={85771020,85771021}
function c85771019.tgfilter(c)
	return c:IsMonster() and c:IsRace(RACE_FAIRY) and c:IsAbleToGrave()
end
function c85771019.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c85771019.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c85771019.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c85771019.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c85771019.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c85771019.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,0)
end
function c85771019.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) or Duel.GetLocationCount(tp,LOCATION_MZONE)<2
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,c85771019+1,0,TYPES_TOKEN,1800,1300,5,RACE_FAIRY,ATTRIBUTE_DARK)
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,c85771019+2,0,TYPES_TOKEN,1200,1200,3,RACE_FAIRY,ATTRIBUTE_DARK) then
		return
	end
	local c=e:GetHandler()
	local asmo_token=Duel.CreateToken(tp,c85771019+1)
	if asmo_token and Duel.SpecialSummonStep(asmo_token,0,tp,tp,false,false,POS_FACEUP) then
		--Cannot be destroyed by card effects
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		asmo_token:RegisterEffect(e1)
	end
	local deus_token=Duel.CreateToken(tp,c85771019+2)
	if deus_token and Duel.SpecialSummonStep(deus_token,0,tp,tp,false,false,POS_FACEUP) then
		--Cannot be destroyed by battle
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		deus_token:RegisterEffect(e2)
	end
	Duel.SpecialSummonComplete()
end