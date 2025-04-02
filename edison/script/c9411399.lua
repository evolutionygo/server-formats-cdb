--Ｄ－ＨＥＲＯ ディアボリックガイ
--Destiny HERO - Malicious
function c9411399.initial_effect(c)
	--Special Summon 1 "Destiny HERO - Malicious" from your Deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc9411399(c9411399,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(aux.SelfBanishCost)
	e1:SetTarget(c9411399.sptg)
	e1:SetOperation(c9411399.spop)
	c:RegisterEffect(e1)
end
c9411399.listed_names={c9411399}
function c9411399.spfilter(c,e,tp)
	return c:IsCode(c9411399) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c9411399.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c9411399.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c9411399.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c9411399.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end