--栄誉の贄 (Anime)
--Offering to the Immortals (Anime)
--fixed by MLD
function c511247015.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511247015(c511247015,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511247015.condition)
	e1:SetTarget(c511247015.target)
	e1:SetOperation(c511247015.activate)
	c:RegisterEffect(e1)
end
c511247015.listed_series={SET_EARTHBOUND_IMMORTAL}
c511247015.listed_names={56339050}
function c511247015.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c511247015.filter(c)
	return (c:IsSetCard(SET_EARTHBOUND_IMMORTAL) or c:IsCode(56339050)) and c:IsAbleToHand()
end
function c511247015.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,82340057,0,TYPES_TOKEN,0,0,1,RACE_ROCK,ATTRIBUTE_EARTH)
		and Duel.IsExistingMatchingCard(c511247015.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511247015.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
		if not Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
			and Duel.IsPlayerCanSpecialSummonMonster(tp,82340057,0,TYPES_TOKEN,0,0,1,RACE_ROCK,ATTRIBUTE_EARTH) then
			for i=1,2 do
				local token=Duel.CreateToken(tp,82340057)
				Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
			end
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c511247015.filter,tp,LOCATION_DECK,0,1,1,nil)
		if #g>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
			Duel.ShuffleHand(tp)
		end
	end
end