--ダストンのモップ
--Magicalized Duston Mop
function c24845628.initial_effect(c)
	c:SetUniqueOnField(1,0,c24845628)
	aux.AddEquipProcedure(c)
	--Equipped monster cannot be Tributed
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_UNRELEASABLE_SUM)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e2)
	--Equipped monster cannot be used as material for a Fusion, Synchro, or Xyz Summon
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_MATERIAL)
	e3:SetValue(aux.cannotmatfilter(SUMMON_TYPE_FUSION,SUMMON_TYPE_SYNCHRO,SUMMON_TYPE_XYZ))
	c:RegisterEffect(e3)
	--Search 1 "Duston" monster
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc24845628(c24845628,0))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCondition(c24845628.thcon)
	e4:SetTarget(c24845628.thtg)
	e4:SetOperation(c24845628.thop)
	c:RegisterEffect(e4)
end
c24845628.listed_series={SET_DUSTON}
function c24845628.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return re and rp==1-tp and c:IsReason(REASON_DESTROY) and c:IsReason(REASON_EFFECT)
		and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c24845628.thfilter(c)
	return c:IsSetCard(SET_DUSTON) and c:IsMonster() and c:IsAbleToHand()
end
function c24845628.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c24845628.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c24845628.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c24845628.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end