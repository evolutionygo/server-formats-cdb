--幻煌の都 パシフィス
--Pacifis, the Phantasm City
function c2819435.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Search 1 "Phantasm Spiral" card
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc2819435(c2819435,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,0,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCondition(c2819435.thcon)
	e2:SetCost(c2819435.cost)
	e2:SetTarget(c2819435.thtg)
	e2:SetOperation(c2819435.thop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--Special Summon  1 "Phantasm Spiral Token"
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringc2819435(c2819435,1))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e6:SetProperty(EFFECT_FLAG_DELAY)
	e6:SetCode(EVENT_CHAINING)
	e6:SetRange(LOCATION_FZONE)
	e6:SetCondition(c2819435.spcon)
	e6:SetCost(c2819435.cost)
	e6:SetTarget(c2819435.sptg)
	e6:SetOperation(c2819435.spop)
	c:RegisterEffect(e6)
	--summon activities registration
	Duel.AddCustomActivityCounter(c2819435,ACTIVITY_SUMMON,c2819435.counterfilter)
	Duel.AddCustomActivityCounter(c2819435,ACTIVITY_SPSUMMON,c2819435.counterfilter)
end
c2819435.listed_names={2819436} -- "Phantasm Spiral Token"
c2819435.listed_series={SET_PHANTASM_SPIRAL}
function c2819435.counterfilter(c)
	return not c:IsType(TYPE_EFFECT)
end
function c2819435.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(c2819435,tp,ACTIVITY_SUMMON)==0
		and Duel.GetCustomActivityCount(c2819435,tp,ACTIVITY_SPSUMMON)==0 end
	--Cannot Normal or Special Summon Effect Monsters
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringc2819435(c2819435,2))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c2819435.splimit)
	e1:SetReset(RESET_PHASE|PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	Duel.RegisterEffect(e2,tp)
end
function c2819435.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	if c:IsMonster() then
		return c:IsType(TYPE_EFFECT)
	else
		return c:IsOriginalType(TYPE_EFFECT)
	end
end
function c2819435.thcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return #eg==1 and tc:IsSummonPlayer(tp) and tc:IsFaceup() and tc:IsType(TYPE_NORMAL)
end
function c2819435.thfilter(c)
	return c:IsSetCard(SET_PHANTASM_SPIRAL) and c:IsAbleToHand()
end
function c2819435.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c2819435.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c2819435.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c2819435.spcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp
end
function c2819435.tknfilter(c)
	return c:IsType(TYPE_TOKEN) or c:IsOriginalType(TYPE_TOKEN)
end
function c2819435.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,c2819435+1,SET_PHANTASM_SPIRAL,TYPES_TOKEN,2000,2000,6,RACE_WYRM,ATTRIBUTE_WATER)
		and e:GetHandler():GetFlagEffect(2819435)==0
		and not Duel.IsExistingMatchingCard(c2819435.tknfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	e:GetHandler():RegisterFlagEffect(2819435,RESET_EVENT|RESETS_STANDARD|RESET_CHAIN,0,1)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function c2819435.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,c2819435+1,SET_PHANTASM_SPIRAL,TYPES_TOKEN,2000,2000,6,RACE_WYRM,ATTRIBUTE_WATER) then
		local token=Duel.CreateToken(tp,c2819435+1)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end