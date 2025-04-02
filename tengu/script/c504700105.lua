--迷宮変化
--Magical Labyrinth
function c504700105.initial_effect(c)
	--Equip procedure
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsCode,67284908))
	--Special Summon "Wall Shadow"
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc504700105(c504700105,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c504700105.spcon)
	e3:SetCost(c504700105.spcost)
	e3:SetTarget(c504700105.sptg)
	e3:SetOperation(c504700105.spop)
	c:RegisterEffect(e3)
end
c504700105.listed_names={63162310,67284908}
function c504700105.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget():GetControler()==tp
end
function c504700105.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetEquipTarget()
	if chk==0 then return c:IsReleasable() and tc:IsReleasable() end
	local g=Group.FromCards(c,tc)
	Duel.Release(g,REASON_COST)
end
function c504700105.spfilter(c,e,tp)
	return c:IsCode(63162310) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c504700105.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if e:GetHandler():GetEquipTarget() and e:GetHandler():GetEquipTarget():GetSequence()<5 then ft=ft+1 end
	if chk==0 then return ft>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c504700105.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c504700105.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	else
		Duel.GoatConfirm(tp,LOCATION_DECK)
	end
end