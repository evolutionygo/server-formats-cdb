--甲虫装機 ホーネット
--Inzektor Hornet
function c69207766.initial_effect(c)
	--Equip 1 "Inzektor" monster to this card
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc69207766(c69207766,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c69207766.eqtg)
	e1:SetOperation(c69207766.eqop)
	c:RegisterEffect(e1)
	aux.AddEREquipLimit(c,nil,c69207766.eqval,c69207766.equipop,e1)
	--Increase ATK/DEF/Level of the equipped monster
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(200)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_LEVEL)
	e4:SetValue(3)
	c:RegisterEffect(e4)
	--Destroy 1 card on the field
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringc69207766(c69207766,1))
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(function(e) return e:GetHandler():GetEquipTarget() end)
	e5:SetCost(c69207766.descost)
	e5:SetTarget(c69207766.destg)
	e5:SetOperation(c69207766.desop)
	c:RegisterEffect(e5)
end
c69207766.listed_series={SET_INZEKTOR}
function c69207766.eqval(ec,c,tp)
	return ec:IsControler(tp) and ec:IsSetCard(SET_INZEKTOR)
end
function c69207766.filter(c)
	return c:IsSetCard(SET_INZEKTOR) and c:IsMonster() and not c:IsForbc69207766den()
end
function c69207766.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c69207766.filter,tp,LOCATION_GRAVE|LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_GRAVE|LOCATION_HAND)
end
function c69207766.equipop(c,e,tp,tc)
	c:EquipByEffectAndLimitRegister(e,tp,tc,nil,true)
end
function c69207766.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c69207766.filter),tp,LOCATION_GRAVE|LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		c69207766.equipop(c,e,tp,tc)
	end
end
function c69207766.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c69207766.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c69207766.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end