--黒炎の騎士－ブラック・フレア・ナイト－
--Dark Flare Knight
function c13722870.initial_effect(c)
	c:EnableReviveLimit()
	--Fusion Materials
	aux.AddFusionProcCode2(c,true,true,CARD_DARK_MAGICIAN,CARD_FLAME_SWORDSMAN)
	--You take no Battle Damage from battles involving this card
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Special Summon 1 "Mirage Knight" from your hand or Deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc13722870(c13722870,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(function(e) return e:GetHandler():IsLocation(LOCATION_GRAVE) end)
	e2:SetTarget(c13722870.sptg)
	e2:SetOperation(c13722870.spop)
	c:RegisterEffect(e2)
end
c13722870.material_setcode=SET_DARK_MAGICIAN
c13722870.listed_names={CARD_DARK_MAGICIAN,CARD_FLAME_SWORDSMAN,49217579} --Mirage Knight
function c13722870.spfilter(c,e,tp)
	return c:IsCode(49217579) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c13722870.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND|LOCATION_DECK)
end
function c13722870.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=Duel.SelectMatchingCard(tp,c13722870.spfilter,tp,LOCATION_HAND|LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if sc and Duel.SpecialSummon(sc,0,tp,tp,true,false,POS_FACEUP)>0 then
		sc:CompleteProcedure()
	end
end