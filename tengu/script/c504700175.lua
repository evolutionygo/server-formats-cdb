--ネフティスの導き手
function c504700175.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc504700175(c504700175,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c504700175.spcost)
	e1:SetTarget(c504700175.sptg)
	e1:SetOperation(c504700175.spop)
	c:RegisterEffect(e1)
end
c504700175.listed_names={61441708}
function c504700175.mzfilter(c,tp)
	return c:IsControler(tp) and c:GetSequence()<5
end
function c504700175.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if c:GetSequence()<5 then ft=ft+1 end
	if chk==0 then return ft>-1 and c:IsReleasable() and Duel.CheckReleaseGroupCost(tp,nil,1,false,nil,c)
		and (ft>0 or Duel.CheckReleaseGroupCost(tp,c504700175.mzfilter,1,false,nil,c,tp)) end
	local rg=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	if ft>0 then
		rg=Duel.SelectReleaseGroupCost(tp,nil,1,1,false,nil,c)
	else
		rg=Duel.SelectReleaseGroupCost(tp,c504700175.mzfilter,1,1,false,nil,c,tp)
	end
	rg:AddCard(c)
	Duel.Release(rg,REASON_COST)
end
function c504700175.filter(c,e,tp)
	return c:IsCode(61441708) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c504700175.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c504700175.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c504700175.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	else
		Duel.GoatConfirm(tp,LOCATION_HAND+LOCATION_DECK)
	end
end