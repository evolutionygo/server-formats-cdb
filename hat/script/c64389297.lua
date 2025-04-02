--迷宮変化
--Magical Labyrinth
function c64389297.initial_effect(c)
	--Equip procedure
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsCode,67284908))
	--Special Summon "Wall Shadow"
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc64389297(c64389297,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c64389297.spcon)
	e3:SetCost(c64389297.spcost)
	e3:SetTarget(c64389297.sptg)
	e3:SetOperation(c64389297.spop)
	c:RegisterEffect(e3)
end
c64389297.listed_names={63162310,67284908}
function c64389297.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget():GetControler()==tp
end
function c64389297.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetEquipTarget()
	if chk==0 then return c:IsReleasable() and tc:IsReleasable() end
	local g=Group.FromCards(c,tc)
	Duel.Release(g,REASON_COST)
end
function c64389297.spfilter(c,e,tp)
	return c:IsCode(63162310) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c64389297.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if e:GetHandler():GetEquipTarget() and e:GetHandler():GetEquipTarget():GetSequence()<5 then ft=ft+1 end
	if chk==0 then return ft>0 and Duel.IsExistingMatchingCard(c64389297.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c64389297.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c64389297.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end