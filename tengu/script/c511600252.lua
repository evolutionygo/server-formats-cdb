--海晶乙女 ブルースラッグ
--Marincess Blue Slug
--scripted by Larry126
local s,c511600252,alias=GetID()
function c511600252.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--link summon
	Link.AddProcedure(c,c511600252.matfilter,1,1)
	c:EnableReviveLimit()
	--recycle
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511600252(alias,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c511600252.thcon)
	e1:SetTarget(c511600252.thtg)
	e1:SetOperation(c511600252.thop)
	c:RegisterEffect(e1)
	aux.GlobalCheck(s,function()
		--splimit
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetCondition(c511600252.sumcon)
		ge1:SetOperation(c511600252.sumlimit)
		Duel.RegisterEffect(ge1,0)
	end)
end
function c511600252.spfilter(c)
	return c:IsCode(alias) and c:IsSummonType(SUMMON_TYPE_LINK)
end
function c511600252.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511600252.spfilter,1,nil)
end
function c511600252.sumlimit(e,tp,eg,ep,ev,re,r,rp)
	local sg=eg:Filter(c511600252.spfilter,nil)
	local c=e:GetHandler()
	for sc in aux.Next(sg) do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetTargetRange(1,0)
		e1:SetTarget(c511600252.splimit)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,sc:GetSummonPlayer())
	end
end
function c511600252.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsCode(alias) and sumtype&SUMMON_TYPE_LINK==SUMMON_TYPE_LINK
end
function c511600252.matfilter(c,lc,sumtype,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0x12b,lc,sumtype,tp)
end
function c511600252.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c511600252.thfilter(c)
	return c:IsSetCard(0x12b) and c:IsMonster() and c:IsAbleToHand()
end
function c511600252.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511600252.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511600252.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c511600252.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c511600252.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end