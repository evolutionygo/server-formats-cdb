--変容王 ヘル・ゲル (Manga)
--Morph King Stygi-Gel (Manga)
local s,c511000763,alias=GetID()
function c511000763.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511000763(alias,0))
	e1:SetCategory(CATEGORY_LVCHANGE+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511000763.condition)
	e1:SetTarget(c511000763.target)
	e1:SetOperation(c511000763.operation)
	c:RegisterEffect(e1)
end
function c511000763.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsStatus(STATUS_SUMMON_TURN+STATUS_SPSUMMON_TURN)
end
function c511000763.filter(c,lv)
	return c:IsFaceup() and c:HasLevel() and c:GetLevel()~=lv
end
function c511000763.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511000763.filter(chkc,e:GetHandler():GetLevel()) end
	if chk==0 then return Duel.IsExistingTarget(c511000763.filter,tp,LOCATION_MZONE,0,1,nil,e:GetHandler():GetLevel()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000763.filter,tp,LOCATION_MZONE,0,1,1,nil,e:GetHandler():GetLevel())
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,1-tp,0)
end
function c511000763.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local lv=c:GetLevel()
	if tc:IsRelateToEffect(e) and c511000763.filter(tc,lv) and c:IsRelateToEffect(e) and c:IsFaceup() then
		local tclv=tc:GetLevel()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(tclv)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE)
		c:RegisterEffect(e1)
		if c:GetLevel()==tclv then
			Duel.Recover(tp,math.abs(lv-tclv)*200,REASON_EFFECT)
		end
	end
end