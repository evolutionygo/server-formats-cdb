--万華鏡－華麗なる分身－
--Elegant Egotist
function c504700157.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c504700157.condition)
	e1:SetTarget(c504700157.target)
	e1:SetOperation(c504700157.activate)
	c:RegisterEffect(e1)
end
c504700157.listed_names={CARD_HARPIE_LADY,CARD_HARPIE_LADY_SISTERS}
function c504700157.cfilter(c)
	return c:IsFaceup() and c:IsCode(CARD_HARPIE_LADY)
end
function c504700157.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c504700157.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c504700157.filter(c,e,tp)
	return c:IsCode(CARD_HARPIE_LADY,CARD_HARPIE_LADY_SISTERS) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c504700157.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c504700157.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c504700157.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		if Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)~=0 then
			tc:CompleteProcedure()
		end
	else
		Duel.GoatConfirm(tp,LOCATION_HAND+LOCATION_DECK)
	end
end