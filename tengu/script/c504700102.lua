--サウザンド・アイズ・サクリファイス
--Thousand-Eyes Restrict (GOAT)
--Gains stats of trap monsters as well
function c504700102.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,64631466,27125110)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc504700102(c504700102,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c504700102.eqcon)
	e1:SetTarget(c504700102.eqtg)
	e1:SetOperation(c504700102.eqop)
	c:RegisterEffect(e1)
	aux.AddEREquipLimit(c,c504700102.eqcon,function(ec,_,tp) return ec:IsControler(1-tp) end,c504700102.equipop,e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c504700102.antarget)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	c:RegisterEffect(e3)
	--atk/def
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_SET_ATTACK)
	e4:SetCondition(c504700102.adcon)
	e4:SetValue(c504700102.atkval)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_SET_DEFENSE)
	e5:SetCondition(c504700102.adcon)
	e5:SetValue(c504700102.defval)	
	c:RegisterEffect(e5)
end
function c504700102.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetEquipGroup():Filter(c504700102.eqfilter,nil)
	return #g==0
end
function c504700102.eqfilter(c)
	return c:GetFlagEffect(c504700102)~=0 
end
function c504700102.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToChangeControler() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c504700102.equipop(c,e,tp,tc)
	if not c:EquipByEffectAndLimitRegister(e,tp,tc,c504700102) then return end
	--substitute
	local e2=Effect.CreateEffect(c)
 	e2:SetType(EFFECT_TYPE_EQUIP)
 	e2:SetCode(EFFECT_DESTROY_SUBSTITUTE)
 	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
 	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
 	e2:SetValue(c504700102.repval)
 	tc:RegisterEffect(e2)		
end
function c504700102.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsMonster() and tc:IsControler(1-tp)  and c504700102.eqcon(e,tp,eg,ep,ev,re,r,rp) then
		c504700102.equipop(c,e,tp,tc)
	end
end
function c504700102.repval(e,re,r,rp)
	return r&REASON_BATTLE~=0
end
function c504700102.antarget(e,c)
	return c~=e:GetHandler()
end
function c504700102.adcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetEquipGroup():Filter(c504700102.eqfilter,nil)
	return #g>0
end
function c504700102.atkval(e,c)
	local c=e:GetHandler()
	local g=c:GetEquipGroup():Filter(c504700102.eqfilter,nil)
	local atk=g:GetFirst():GetTextAttack()
	if g:GetFirst():IsFacedown() or atk<0 then
		return 0
	else
		return atk
	end
end
function c504700102.defval(e,c)
	local c=e:GetHandler()
	local g=c:GetEquipGroup():Filter(c504700102.eqfilter,nil)
	local def=g:GetFirst():GetTextDefense()
	if g:GetFirst():IsFacedown() or def<0 then
		return 0
	else
		return def
	end
end